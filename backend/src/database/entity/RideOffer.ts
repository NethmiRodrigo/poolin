import { Geometry } from "geojson";
import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  BaseEntity,
  Index,
  CreateDateColumn,
  UpdateDateColumn,
  Double,
  OneToMany,
  ManyToOne,
} from "typeorm";
import { RequestToOffer } from "./RequestToOffer";
import { RideRequest } from "./RideRequest";
import { User } from "./User";

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
  @Column({ nullable: false, default: true })
  isActive: boolean;
  @Column({ default: false })
  isDeleted: boolean;
  @CreateDateColumn()
  createdAt: Date;
  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(() => User, (user) => user.offers)
  user: User;

  @OneToMany(() => RequestToOffer, (requestToOffer) => requestToOffer.offer)
  public requestsToOffer: RequestToOffer[];
}
