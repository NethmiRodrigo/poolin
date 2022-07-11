import { IsEmail, Length } from "class-validator";
import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  BaseEntity,
  Index,
  CreateDateColumn,
  UpdateDateColumn,
  BeforeInsert,
} from "typeorm";
import bcrypt from "bcrypt";
import { Exclude, instanceToPlain } from "class-transformer";

@Entity("temp_users")
export class TempUser extends BaseEntity {
  // constructor(tempUser?: Partial<TempUser>) {
  //   super();
  //   Object.assign(this, tempUser);
  // }

  @Exclude()
  @PrimaryGeneratedColumn()
  id: number;

  @Index()
  @IsEmail()
  @Column({ unique: true })
  email: string;

  @Column({ nullable: true })
  @Length(8, 255, { message: "Password must be atleast 8 characters" })
  password: string;

  @CreateDateColumn()
  createdAt: Date;

  @Column({ nullable: true })
  emailOTP: string;

  @Column({ nullable: true })
  emailOTPSentAt: Date;

  @Column({ nullable: true })
  smsOTP: string;

  @Column({ nullable: true })
  smsOTPSentAt: Date;

  @BeforeInsert()
  async hashPassword() {
    this.password = await bcrypt.hash(this.password, 8);
  }

  toJSON() {
    return instanceToPlain(this);
  }
}
