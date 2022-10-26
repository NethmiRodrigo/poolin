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

export type Status = "active" | "completed" | "cancelled" | "booked";

@Entity()
export class RideOffer extends BaseEntity {
  constructor(rideOffer?: Partial<RideOffer>) {
    super();
    Object.assign(this, rideOffer);
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

  @Column({
    type: "geometry",
    spatialFeatureType: "LineString",
    nullable: true,
  })
  polyline: Geometry;

  @Column({ nullable: false })
  departureTime: Date;

  @Column({ nullable: false })
  arrivalTime: Date;

  @Column({ nullable: false })
  pricePerKm: number;

  @Column({ nullable: false })
  seats: number;

  @Column("decimal", { nullable: false })
  distance: number;

  @CreateDateColumn()
  createdAt: Date;
  @UpdateDateColumn()
  updatedAt: Date;

  @Column({
    type: "enum",
    enum: ["completed", "cancelled", "booked"],
    default: "booked",
  })
  status: Status;

  @ManyToOne(() => User, (user) => user.offers)
  user: User;

  @OneToMany(() => RequestToOffer, (requestToOffer) => requestToOffer.offer)
  public requestsToOffer: RequestToOffer[];
}
