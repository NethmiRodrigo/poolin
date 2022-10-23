import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  BaseEntity,
  CreateDateColumn,
  UpdateDateColumn,
  OneToMany,
  ManyToOne,
} from "typeorm";
import { User } from "./User";

export enum Action {
  NONE = "none",
  BLACKLIST = "blacklist",
}

export enum Status {
  OPEN = "open",
  CLOSED = "closed",
}

@Entity()
export class Complaint extends BaseEntity {
  constructor(complaint?: Partial<Complaint>) {
    super();
    Object.assign(this, complaint);
  }

  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => User, (user) => user.complaintsGiven)
  complainee: User;
  @ManyToOne(() => User, (user) => user.complaintsReceived)
  complainer: User;

  @Column()
  tripId: number;

  @Column()
  description: string;

  @Column({
    type: "enum",
    enum: Status,
    default: Status.OPEN,
  })
  status: Status;

  @Column({
    type: "enum",
    enum: Action,
    default: Action.NONE,
  })
  action: Action;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
