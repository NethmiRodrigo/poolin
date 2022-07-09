import { IsEmail } from "class-validator";
import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  BaseEntity,
} from "typeorm";
import { Exclude, instanceToPlain } from "class-transformer";

@Entity("email_format")
export class EmailFormat extends BaseEntity {
  constructor(emailFormat?: Partial<EmailFormat>) {
    super();
    Object.assign(this, emailFormat);
  }

  @Exclude()
  @PrimaryGeneratedColumn()
  id: number;

  @IsEmail()
  @Column({ nullable: false })
  emailFormat: string;

  toJSON() {
    return instanceToPlain(this);
  }
}
