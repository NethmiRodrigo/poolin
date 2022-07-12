import { IsEmail } from "class-validator";
import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  BaseEntity,
  Index,
  CreateDateColumn,
  UpdateDateColumn
} from "typeorm";
import { Exclude } from "class-transformer";

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
  @Column({ unique: true })
  mobile: string;

  @Index()
  @Column({ nullable: true })
  @Exclude()
  name: string;

  @Column()
  password: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
