import express from "express";

const app = express();
const HOST = "localhost";
const PORT = 3000;

app.use(express.static('../public'));

app.listen(PORT, HOST, () => {
  console.log(`Express server listening at http://${HOST}:${PORT}`);
});
