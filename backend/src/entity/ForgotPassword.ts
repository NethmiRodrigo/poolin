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
import { Exclude, instanceToPlain } from "class-transformer";

@Entity()
export class ForgotPassword extends BaseEntity {
  constructor(object?: Partial<ForgotPassword>) {
    super();
    Object.assign(this, object);
  }

  @Exclude()
  @PrimaryGeneratedColumn()
  id: number;

  @Index()
  @IsEmail()
  @Column()
  email: string;

  @Index()
  @Column()
  otp: string;

  @CreateDateColumn()
  createdAt: Date;

  @Column()
  expiresAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  toJSON() {
    return instanceToPlain(this);
  }
}
