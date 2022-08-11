import app from "./app";
import { AppDataSource } from "./data-source";
import { getDuration } from "./middleware/duration";
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
    getDuration(
      {
        lat: 6.976169957981979,
        long: 79.91791374393554,
      },
      {
        lat: 6.90202943722697,
        long: 79.86298071984876,
      }
    );
  } catch (error) {
    console.log(error);
  }
});
