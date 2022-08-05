import { Geometry } from "geojson";
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
import { RequestToOffer } from "./RequestToOffer";
import { User } from "./User";

export type Status = "active" | "completed" | "cancelled" | "confirmed";

@Entity()
export class RideRequest extends BaseEntity {
  constructor(rideRequest?: Partial<RideRequest>) {
    super();
    Object.assign(this, rideRequest);
  }
  @PrimaryGeneratedColumn()
  id: number;

  @Column({
    type: "geometry",
    spatialFeatureType: "Point",
  })
  fromGeom: Geometry;

  @Column({
    type: "geometry",
    spatialFeatureType: "Point",
  })
  toGeom: Geometry;

  @Column({ nullable: false })
  from: string;

  @Column({ nullable: false })
  to: string;

  @Column({ nullable: false })
  departureTime: Date;

  @Column({ nullable: false })
  timeWindow: number;

  @Column("decimal", { nullable: false })
  distance: number;

  @CreateDateColumn()
  createdAt: Date;
  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(() => User, (user) => user.requests, { eager: true })
  user: User;

  @Column({
    type: "enum",
    enum: ["active", "completed", "cancelled", "confirmed"],
    default: "active",
  })
  status: Status;

  @OneToMany(() => RequestToOffer, (requestToOffer) => requestToOffer.request)
  public requestToOffers: RequestToOffer[];
}
