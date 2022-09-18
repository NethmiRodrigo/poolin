import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  BaseEntity,
  CreateDateColumn,
  UpdateDateColumn,
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

  @Column({ type: "decimal", precision: 7, scale: 2, nullable: false })
  price: number;

  @Column({ nullable: false, default: false })
  isAccepted: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(() => RideOffer, (offer) => offer.requestsToOffer)
  public offer: RideOffer;

  @ManyToOne(() => RideRequest, (request) => request.requestToOffers)
  public request: RideRequest;
}
