import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  BaseEntity,
} from "typeorm";
import { Exclude, instanceToPlain } from "class-transformer";

@Entity("email_formats")
export class EmailFormat extends BaseEntity {
  constructor(emailFormat?: Partial<EmailFormat>) {
    super();
    Object.assign(this, emailFormat);
  }

  @Exclude()
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  emailFormat: string;

  toJSON() {
    return instanceToPlain(this);
  }
}
