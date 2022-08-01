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
import { RideOffer } from "./RideOffer";
import { RideRequest } from "./RideRequest";

@Entity()
export class RequestToOffer extends BaseEntity {
  constructor(requestToOffer?: Partial<RequestToOffer>) {
    super();
    Object.assign(this, requestToOffer);
  }
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  offerId: number;

  @Column({ nullable: false })
  requestId: number;

  @Column("decimal", { nullable: false })
  price: number;

  @Column({ nullable: false, default: false })
  isAccepted: boolean;

  @Column({ default: false })
  isDeleted: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(() => RideOffer, (offer) => offer.requestToOffers)
  public offer: RideOffer;

  @ManyToOne(() => RideRequest, (request) => request.requestToOffers)
  public request: RideRequest;
}
