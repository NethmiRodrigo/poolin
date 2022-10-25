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
import { RideRequest } from "./RideRequest";
  
  
  @Entity()
  export class Payment extends BaseEntity {
    constructor(payment?: Partial<Payment>) {
      super();
      Object.assign(this, payment);
    }
  
    @Exclude()
    @PrimaryGeneratedColumn()
    id: number;
  
    @Column()
    driverID: number;
  
    @Column()
    numberOfPassengers: number;

    @Column()
    totalIncome: number;
  
    @Column()
    totalPayable: number;

    @Column()
    totalProfit: number;

    @ManyToOne(() => RideRequest, (RideRequest) => RideRequest.id, {
      cascade: ["remove"],
      onDelete: "CASCADE",
    })
    owner: User;
  
  
    @CreateDateColumn()
    paymentDate: Date;
  
  }
  