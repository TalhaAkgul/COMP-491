/*!

=========================================================
* Paper Kit React - v1.3.1
=========================================================

* Product Page: https://www.creative-tim.com/product/paper-kit-react

* Copyright 2022 Creative Tim (https://www.creative-tim.com)
* Licensed under MIT (https://github.com/creativetimofficial/paper-kit-react/blob/main/LICENSE.md)

* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

*/
import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter, Route, Redirect, Switch } from "react-router-dom";

// styles
import "bootstrap/scss/bootstrap.scss";
import "assets/scss/paper-kit.scss?v=1.3.0";
import "assets/demo/demo.css?v=1.3.0";
// pages
import MyLandingPage from "views/MyLandingPage.js";
import MyProvisions from "views/MyProvisions.js";
import MakeProvisions from "views/MakeProvision.js";
// others

const root = ReactDOM.createRoot(document.getElementById("root"));

root.render(
  <React.StrictMode>
  <BrowserRouter>
    <Switch>
      
      <Route
        path="/my-landing-page"
        render={(props) => <MyLandingPage {...props} />}
      />
      <Route
        path="/my-provisions"
        render={(props) => <MyProvisions {...props} />}
      />
      <Route
        path="/make-provision"
        render={(props) => <MakeProvisions {...props} />}
      />

      <Redirect to="/my-landing-page" />
    </Switch>
  </BrowserRouter>
  </React.StrictMode>
);
