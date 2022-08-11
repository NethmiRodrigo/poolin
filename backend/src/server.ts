import app from "./app";
import { AppDataSource } from "./data-source";
import { getPolyline } from "./middleware/polyline";

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
    console.log("Database is connected!");
  } catch (error) {
    console.log(error);
  }
});
