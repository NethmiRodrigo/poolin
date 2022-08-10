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

@Entity()
export class OfferRoute extends BaseEntity {
  constructor(offerRoute?: Partial<OfferRoute>) {
    super();
    Object.assign(this, offerRoute);
  }

  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  from: string;

  @Column({ nullable: false })
  to: string;

  @Column({
    type: "geometry",
    spatialFeatureType: "LineString",
  })
  polylineStart: Geometry;

  @Column({
    type: "geometry",
    spatialFeatureType: "LineString",
  })
  polylineEnd: Geometry;
}
