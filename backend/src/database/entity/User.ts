import { IsEmail } from "class-validator";
import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  BaseEntity,
  Index,
  CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";
import { Exclude } from "class-transformer";

export enum Gender {
  MALE = "male",
  FEMALE = "female",
  UNKNOWN = "unknown",
}

export enum Role {
  USER = "user",
  ADMIN = "admin",
}

@Entity("users")
export class User extends BaseEntity {
  constructor(user?: Partial<User>) {
    super();
    Object.assign(this, user);
  }

  @Exclude()
  @PrimaryGeneratedColumn()
  id: number;

  @Index()
  @IsEmail()
  @Column({ unique: true })
  email: string;

  @Index()
  @Column({ unique: true, nullable: true })
  mobile: string;

  @Index()
  @Column({ nullable: true })
  @Exclude()
  firstname: string;

  @Index()
  @Column({ nullable: true })
  @Exclude()
  lastname: string;

  @Column({
    type: "enum",
    enum: Gender,
    default: Gender.UNKNOWN,
  })
  gender: Gender;

  @Column({ nullable: true })
  @Exclude()
  profileImageUri: string;

  @Column()
  password: string;

  @Column({ nullable: true })
  @Exclude()
  occupation: string;

  @Column({ nullable: true })
  @Exclude()
  dateOfBirth: Date;

  @Column({ nullable: true })
  smsOTP: string;

  @Column({ nullable: true })
  smsOTPSentAt: Date;

  @Column({ default: false })
  isVerified: boolean;

  @Column({ default: Role.USER })
  role: Role;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
