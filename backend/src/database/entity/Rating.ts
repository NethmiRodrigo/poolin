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

export enum Role {
  RIDER = "rider",
  DRIVER = "driver",
}

@Entity()
export class Rating extends BaseEntity {
  constructor(rating?: Partial<Rating>) {
    super();
    Object.assign(this, rating);
  }

  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => User, (user) => user.ratingsGiven)
  ratingFor: User;
  @ManyToOne(() => User, (user) => user.ratingsReceived)
  ratingBy: User;

  @Column()
  ratingFor: number;

  @Column()
  tripId: number;

  @Column()
  ratingBy: number;

  @Column({
    type: "enum",
    enum: Role,
  })
  ratedAs: Role;

  @Column()
  rating: number;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
