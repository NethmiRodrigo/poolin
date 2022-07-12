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

  @Column({ nullable: true })
  @Exclude()
  fName: string;

  @Column({ nullable: false })
  @Exclude()
  lName: string;

  @Column({ nullable: false })
  @Exclude()
  gender: string;

  @Column()
  @Length(8, 255, { message: "Password must be atleast 8 characters" })
  password: string;

  @Column({nullable: false})
  @Exclude()
  mobile: string;

  @Column({nullable: false})
  @Exclude()
  occupation: string;

  @Column({nullable: true})
  @Exclude()
  dateOfBirth: Date;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @BeforeInsert()
  async hashPassword() {
    this.password = await bcrypt.hash(this.password, 8);
  }

  toJSON() {
    return instanceToPlain(this);
  }
}
