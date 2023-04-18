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

// reactstrap components
import { Button, Card, Form, Label,  FormGroup,  Input, Container, Row, Col } from "reactstrap";

// core components
import ExamplesNavbar from "components/Navbars/ExamplesNavbar.js";
import CreditCard from "components/Elements/CreditCard";

function RegisterPage() {
  document.documentElement.classList.remove("nav-open");
  React.useEffect(() => {
    document.body.classList.add("register-page");
    return function cleanup() {
      document.body.classList.remove("register-page");
    };
  });
  return (
    <>
      <ExamplesNavbar />
      <div
        className="page-header"
        style={{
          backgroundImage: "url(" + require("assets/img/login-image.jpg") + ")"
        }}
      >
        <div className="filter" />
        <Container>
          <Row>
            <Col className="ml-auto mr-auto" lg="4">
                <Row>
                  <FormGroup className="col-sm">
                    <Label for="text">Name</Label>
                    <Input type="text" id="name" placeholder="Name" />
                  </FormGroup>
                </Row>

                <Row>
                  <FormGroup className="col-sm">
                    <Label for="Surname">Surname</Label>
                    <Input type="text" id="surname" placeholder="Surname" />
                  </FormGroup>
                </Row>

                <Row>
                  <FormGroup className="col-sm">
                    <Label for="inputEmail">Email</Label>
                    <Input type="email" id="inputEmail" placeholder="Email" />
                  </FormGroup>
                </Row>

                <Row>
                  <FormGroup className="col-sm-6">
                    <Label for="airline">Flight Number</Label>
                    <Input type="text" id="airline" placeholder="Initials" />
                  </FormGroup>
                  <FormGroup className="col-sm-6 ">
                    <Label for="airline" style={{ opacity: 0 }}>
                      this is a hidden element
                    </Label>
                    <Input
                      type="text"
                      pattern="[0-9]*"
                      title="Numbers Only"
                      required="'required'"
                      id="flightnum"
                      placeholder="Number"
                    />
                  </FormGroup>
                </Row>
              </Col>
            <Col className="ml-auto mr-auto" lg="4">
              <FormGroup className="col-sm">
                <CreditCard />
              </FormGroup>

            </Col>
          </Row>
        </Container>
        <div className="footer register-footer text-center">
          <h6>
            © {new Date().getFullYear()}, made with{" "}
            <i className="fa fa-heart heart" /> by Creative Tim
          </h6>
        </div>
      </div>
    </>
  );
}

export default RegisterPage;
