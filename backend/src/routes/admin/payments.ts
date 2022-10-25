import { Request, Response } from "express";

/** Entities */
import { Payment } from "../../database/entity/Payment";

/** Utility functions */
import { AppError } from "../../util/error-handler";

import { AppDataSource } from "../../data-source";


/**
 *
 * Fetch total income
 */
 export const fetchTotalIncome = async (req: Request, res: Response) => {
    // const { id, verified } = req.params;
  
    const paymentRepository =  AppDataSource.getRepository(Payment);
    const totalIncome =  await paymentRepository
    .createQueryBuilder('payment')
    // .select('SUM(payment.totalIncome)', 'totalIncome',)
    // // .where('payment.paymentDate > CURRENT_DATE - 7')
    // .groupBy('payment.driverID')
    .getRawMany();
    
    return res.json({ totalIncome });
  };