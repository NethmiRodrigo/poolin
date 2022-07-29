import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  BaseEntity,
  Index,
  CreateDateColumn,
  UpdateDateColumn,
  ManyToOne,
} from "typeorm";
import { Exclude } from "class-transformer";
import { User } from "./User";

export enum Type {
  SEDAN = "sedan",
  SUV = "suv",
  VAN = "van",
}

@Entity()
export class Vehicle extends BaseEntity {
  constructor(vehicle?: Partial<Vehicle>) {
    super();
    Object.assign(this, vehicle);
  }

  @Exclude()
  @PrimaryGeneratedColumn()
  id: number;

  @Index()
  @Column({ unique: true })
  numberPlate: string;

  @Column()
  numberOfSeats: number;

  @ManyToOne(() => User, (user) => user.vehicles, {
    cascade: ["remove"],
    onDelete: "CASCADE",
  })
  owner: User;

  @Column({
    type: "enum",
    enum: Type,
  })
  type: Type;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
