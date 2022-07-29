import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  BaseEntity,
  CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";

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
