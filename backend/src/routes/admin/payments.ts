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
    .select('SUM(payment.totalIncome)', 'totalIncome')
    .where('payment.paymentDate > CURRENT_DATE - 7')
    .getRawOne();
    
    return res.json({ totalIncome });
  };

  /**
 *
 * Fetch total payable
 */
 export const fetchTotalPayabale = async (req: Request, res: Response) => {
    // const { id, verified } = req.params;
  
    const paymentRepository =  AppDataSource.getRepository(Payment);
    const totalPayable =  await paymentRepository
    .createQueryBuilder('payment')
    .select('SUM(payment.totalPayable)', 'totalPayable')
    //.where('payment.paymentDate > CURRENT_DATE - 7')
    .getRawOne();
    
    return res.json({ totalPayable });
  };

/**
 *
 * Fetch total payable past week 
 */
 export const fetchTotalPayabaleWeek = async (req: Request, res: Response) => {
    // const { id, verified } = req.params;
  
    const paymentRepository =  AppDataSource.getRepository(Payment);
    const totalPayableWeek =  await paymentRepository
    .createQueryBuilder('payment')
    .select('SUM(payment.totalPayable)', 'totalPayableWeek')
    .where('payment.paymentDate > CURRENT_DATE - 7')
    .getRawOne();
    
    return res.json({ totalPayableWeek });
  };

  /**
 *
 * Fetch total payable past week 
 */
 export const fetchTotalProfit = async (req: Request, res: Response) => {
    // const { id, verified } = req.params;
  
    const paymentRepository =  AppDataSource.getRepository(Payment);
    const totalProfit =  await paymentRepository
    .createQueryBuilder('payment')
    .select('SUM(payment.totalProfit)', 'totalProfit')
    .where('payment.paymentDate > CURRENT_DATE - 7')
    .getRawOne();
    
    return res.json({ totalProfit });
  };

  
  /**
 *
 * Fetch all payments
 */
export const fetchAllPayments = async (req: Request, res: Response) => {
    // const { id, verified } = req.params;
  
    const userRepository = await AppDataSource.getRepository(Payment);
    const allPayments = await userRepository.find();
    //console.log("All payments: ", allPayments);
    return res.json({ allPayments });
  };
  

