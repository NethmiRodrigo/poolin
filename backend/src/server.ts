import app from "./app";
import { AppDataSource } from "./data-source";
import { EmailFormat } from "./entity/EmailFormat";

app.listen(process.env.PORT, async () => {
  console.log(`
  ▄███████▄  ▄██████▄   ▄██████▄   ▄█             ▄█   ███▄▄▄▄   
  ███    ███ ███    ███ ███    ███ ███                 ███▀▀▀██▄ 
  ███    ███ ███    ███ ███    ███ ███            ███▌ ███   ███ 
  ███    ███ ███    ███ ███    ███ ███            ███▌ ███   ███ 
▀█████████▀  ███    ███ ███    ███ ███            ███▌ ███   ███ 
  ███        ███    ███ ███    ███ ███            ███  ███   ███ 
  ███        ███    ███ ███    ███ ███▌    ▄      ███  ███   ███ 
 ▄████▀       ▀██████▀   ▀██████▀  █████▄▄██      █▀    ▀█   █▀  
                                   ▀                             
                 🚘 Pool-in server running at https://localhost:${process.env.PORT}                                                                                                                                           
  `);
  try {
    await AppDataSource.initialize();
    await EmailFormat.create({
      emailFormat: "stu.ucsc.lk",
    }).save();
    console.log("Database is connected!");
  } catch (error) {
    console.log(error);
  }
});
