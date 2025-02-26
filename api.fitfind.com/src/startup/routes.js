import adminPanelRoute from "../routes/ap/index.js";
import mobileAppRoute from "../routes/ma/index.js";
import merchantPanelRoute from "../routes/mp/index.js";
import fileRoute from "../routes/file.js";

var healthHTML =
  process.env.MODE == "development"
    ? `
    <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fit Find Server Health Check</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #6c00ff, #6c00ff);
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }

        .container {
            background-color: white;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            border-radius: 12px;
            padding: 40px;
            max-width: 500px;
            width: 90%;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .container:hover {
            cursor: progress;
            transform: translateY(-10px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.5);
        }

        h1 {
            font-size: 2.3rem;
            color: #6c00ff;
            margin-bottom: 20px;
        }

        p {
            font-size: 1.2rem;
            color: #555;
            margin-bottom: 15px;
        }

        .status {
            font-size: 1.6rem;
            font-weight: bold;
            margin-top: 20px;
        }

        .status span {
            color: #4caf50;
        }

        .footer {
            font-size: 0.9rem;
            margin-top: 30px;
            color: #666;
            font-style: italic;
        }

        .footer a {
            color: #6c00ff;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            h1 {
                font-size: 2rem;
            }

            p {
                font-size: 1rem;
            }

            .status {
                font-size: 1.3rem;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <h1>FitFind Dev Server is Online</h1>
        <p>Your server is running smoothly and efficiently.</p>
        <div class="status">Status: <span>Operational</span></div>
        <div class="footer">Powered by <a href="https://www.thenextlevelsoftware.com" target="_blank">Next Level Software</a></div>
    </div>
</body>

</html>

`
    : `
    <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitFind Server Health Check</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #16a34a, #4caf50);
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }

        .container {
            background-color: white;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            border-radius: 12px;
            padding: 40px;
            max-width: 500px;
            width: 90%;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .container:hover {
            cursor: progress;
            transform: translateY(-10px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.5);
        }

        h1 {
            font-size: 2.3rem;
            color: #16a34a;
            margin-bottom: 20px;
        }

        p {
            font-size: 1.2rem;
            color: #555;
            margin-bottom: 15px;
        }

        .status {
            font-size: 1.6rem;
            font-weight: bold;
            margin-top: 20px;
        }

        .status span {
            color: #4caf50;
        }

        .footer {
            font-size: 0.9rem;
            margin-top: 30px;
            color: #666;
            font-style: italic;
        }

        .footer a {
            color: #16a34a;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            h1 {
                font-size: 2rem;
            }

            p {
                font-size: 1rem;
            }

            .status {
                font-size: 1.3rem;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <h1>FitFind Server is Online</h1>
        <p>Your server is running smoothly and efficiently.</p>
        <div class="status">Status: <span>Operational</span></div>
        <div class="footer">Powered by <a href="https://www.thenextlevelsoftware.com" target="_blank">Next Level Software</a></div>
    </div>
</body>

</html>

`;

export default function (app) {
  app.use("/ap", adminPanelRoute);
  app.use("/ma", mobileAppRoute);
  app.use("/mp", merchantPanelRoute);
  app.use("/file", fileRoute);

  app.get("/", (req, res) => {
    res.send(healthHTML);
  });
}
