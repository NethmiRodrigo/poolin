import { IsEmail, Length } from "class-validator";
import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  BaseEntity,
  Index,
  CreateDateColumn,
  BeforeInsert,
} from "typeorm";
import bcrypt from "bcrypt";
import { Exclude, instanceToPlain } from "class-transformer";

export enum VerificationStatus { 
  VERIFIED = 'verified',
  UNVERIFIED = 'unverified'
};

@Entity("temp_users")
export class TempUser extends BaseEntity {
  constructor(tempUser?: Partial<TempUser>) {
    super();
    Object.assign(this, tempUser);
  }

  @Exclude()
  @PrimaryGeneratedColumn()
  id: number;

  @Index()
  @IsEmail()
  @Column({ unique: true })
  email: string;

  @Column()
  @Length(8, 255, { message: "Password must be atleast 8 characters" })
  password: string;

  @CreateDateColumn()
  createdAt: Date;

  @Column({ nullable: true })
  emailOTP: string;

  @Column({ nullable: true })
  emailOTPSentAt: Date;

  @Column({
    type: 'enum',
    enum: VerificationStatus,
    default: VerificationStatus.UNVERIFIED
  })
  emailStatus: VerificationStatus;

  @Index()
  @Column({ nullable: true })
  mobile: string;

  @Column({ nullable: true })
  smsOTP: string;

  @Column({ nullable: true })
  smsOTPSentAt: Date;

  @Column({
    type: 'enum',
    enum: VerificationStatus,
    default: VerificationStatus.UNVERIFIED
  })
  mobileStatus: VerificationStatus;

  @BeforeInsert()
  async hashPassword() {
    this.password = await bcrypt.hash(this.password, 8);
  }

  toJSON() {
    return instanceToPlain(this);
  }
}
