import Head from "next/head";
import { CacheProvider } from "@emotion/react";
import LocalizationProvider from "@mui/lab/LocalizationProvider";
import AdapterDateFns from "@mui/lab/AdapterDateFns";
import { CssBaseline } from "@mui/material";
import { ThemeProvider } from "@mui/material/styles";
import { createEmotionCache } from "../utils/create-emotion-cache";
import { theme } from "../theme";
import { ToastContainer } from "react-toastify";

import "react-toastify/dist/ReactToastify.css";
import { useEffect } from "react";
import { useRouter } from "next/router";
import axios from "axios";

const clientSideEmotionCache = createEmotionCache();

const App = (props) => {
  const { Component, emotionCache = clientSideEmotionCache, pageProps } = props;

  const getLayout = Component.getLayout ?? ((page) => page);

  const router = useRouter();

  useEffect(() => {
    const cookie = localStorage.getItem("Cookie");
    if (!cookie) router.push("/login");
    if (cookie) axios.defaults.headers.common["cookie"] = cookie;
  }, []);

  return (
    <CacheProvider value={emotionCache}>
      <Head>
        <title>Poolin</title>
        <meta name="viewport" content="initial-scale=1, width=device-width" />
      </Head>
      <LocalizationProvider dateAdapter={AdapterDateFns}>
        <ThemeProvider theme={theme}>
          <ToastContainer />
          <CssBaseline />
          {getLayout(<Component {...pageProps} />)}
        </ThemeProvider>
      </LocalizationProvider>
    </CacheProvider>
  );
};

export default App;
