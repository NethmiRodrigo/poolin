import { Exclude } from "class-transformer";
import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from "typeorm";
import { User } from "./User";

@Entity()
export class VerificationDocument extends BaseEntity {
  constructor(document?: Partial<VerificationDocument>) {
    super();
    Object.assign(this, document);
  }

  @Exclude()
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => User, (user) => user.verificationDocuments)
  user: User;

  @Column()
  documentURI: string;

  @Column({ default: false })
  isVerified: boolean;

  @Column()
  type: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
