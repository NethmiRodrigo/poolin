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
import { RideOffer } from "./RideOffer";
import { User } from "./User";

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

  // @Column("decimal", { nullable: false })
  // price: number;

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

  @ManyToOne(() => User, (user) => user.requests)
  user: User;

  @OneToMany(() => RequestToOffer, (requestToOffer) => requestToOffer.request)
  public requestToOffers: RequestToOffer[];
}
