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
import styled from "styled-components";
// reactstrap components
import {
  Button,
  Label,
  FormGroup,
  Input,
  NavItem,
  NavLink,
  Nav,
  TabContent,
  TabPane,
  Form,
  Container,
  Row,
  Col,
} from "reactstrap";

// core components
import ExamplesNavbar from "components/Navbars/MyNavbar.js";
import ProfilePageHeader from "components/Headers/ProfilePageHeader.js";
import DemoFooter from "components/Footers/DemoFooter.js";
import CreditCard from "components/Elements/CreditCard";
function getDisplayCardNumber(numberInput) {
  const placeholder = "****************";
  const newPlaceholder = placeholder.substr(numberInput.length);

  return numberInput.concat("", newPlaceholder).match(/.{1,4}/g);
}

function ProfilePage() {
  const [activeTab, setActiveTab] = React.useState("1");

  const toggle = (tab) => {
    if (activeTab !== tab) {
      setActiveTab(tab);
    }
  };

  document.documentElement.classList.remove("nav-open");
  React.useEffect(() => {
    document.body.classList.add("landing-page");
    return function cleanup() {
      document.body.classList.remove("landing-page");
    };
  });
  const initialState = {
    name: "",
    number: "",
    expiryMonth: "",
    expiryYear: "",
    cvv: "",
  };

  const inputReducer = (state, action) => {
    return { ...state, [action.key]: action.value };
  };

  const [cardInfo, handleOnChange] = React.useReducer(
    inputReducer,
    initialState
  );
  return (
    <>
      <ExamplesNavbar />
      <ProfilePageHeader />
      <div className="section profile-content">
        <Container>
          <br />
          <Form>
            <Row>
              <Col md="6">
                <Row>
                  <FormGroup className="col-sm-8">
                    <Label for="text">Name</Label>
                    <Input type="text" id="name" placeholder="Name" />
                  </FormGroup>
                </Row>

                <Row>
                  <FormGroup className="col-sm-8">
                    <Label for="Surname">Surname</Label>
                    <Input type="text" id="surname" placeholder="Surname" />
                  </FormGroup>
                </Row>

                <Row>
                  <FormGroup className="col-sm-8">
                    <Label for="inputEmail">Email</Label>
                    <Input type="email" id="inputEmail" placeholder="Email" />
                  </FormGroup>
                </Row>

                <Row>
                  <FormGroup className="col-sm-3">
                    <Label for="airline">Flight Number</Label>
                    <Input type="text" id="airline" placeholder="Initials" />
                  </FormGroup>
                  <FormGroup className="col-sm-5">
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

              <Col md="2">
                <br />
                <FormGroup className="col-sm-6">
                  <CreditCard />
                </FormGroup>
              </Col>
            </Row>
          </Form>
          <br />
        </Container>
      </div>
      <DemoFooter />
    </>
  );
}

export default ProfilePage;
