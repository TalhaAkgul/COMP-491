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
import { useState, useEffect } from "react";

import styled from "styled-components";
import Cleave from "cleave.js/react";
import anime from "animejs/lib/anime.es.js";
import "assets/css/card.css";
// reactstrap components

import {
  FaCcAmex,
  FaCcDinersClub,
  FaCcDiscover,
  FaCcJcb,
  FaCcMastercard,
  FaCcVisa,
  FaCreditCard,
} from "react-icons/fa";
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

  var [search, setSearch] = useState("");
  var [name, setName] = useState("");
  var [surname, setSurname] = useState("");
  var [email, setEmail] = useState("");
  var [callSign, setCallSign] = useState("");
  var [flightNo, setFlightNo] = useState("");

  const [cardNumber, setCardNumber] = useState("");
  const [cardHolderName, setCardHolderName] = useState("");
  const [expirationDate, setExpirationDate] = useState("");
  const [cardType, setCardType] = useState("");
  const [cvv, setCvv] = useState("");

  const handleSubmit = async(e) => {
    e.preventDefault();

    const data = {
      name,
      surname,
      email,
      callSign,
      flightNo,
      cardType,
      cardNumber,
      cardHolderName,
      expirationDate,
      cvv
    };

    const response = await fetch("https://172.16.126.233:8080/deneme", {

      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    });

    if (response.ok) {
      alert("Form submitted successfully" + cvv);
    } else {
      alert("Form submission failed");
    }
    e.target.reset();

  };

  return (
    <>
      <ExamplesNavbar />
      <ProfilePageHeader />
      <div className="section profile-content">
        <Container>
          <br />
          <Form onSubmit={handleSubmit}>
            <Row>
              <Col md="6">
                <Row>
                  <FormGroup className="col-sm-8">
                    <Label for="text">Name</Label>
                    <Input 
                      type="text" 
                      id="name"
                      required="'required'"
                      pattern="[A-Za-zıöçşğü]*"
                      onChange={(e) => setName(e.target.value)} 
                      placeholder="Name" />
                  </FormGroup>
                </Row>

                <Row>
                  <FormGroup className="col-sm-8">
                    <Label for="Surname">Surname</Label>
                    <Input 
                      type="text"
                      id="surname" 
                      required="'required'"
                      pattern="[A-Za-zıöçşğü]*"
                      onChange={(e) => setSurname(e.target.value)} 
                      placeholder="Surname" />
                  </FormGroup>
                </Row>

                <Row>
                  <FormGroup className="col-sm-8">
                    <Label for="inputEmail">Email</Label>
                    <Input 
                      type="email" 
                      id="inputEmail" 
                      required="'required'"
                      pattern="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"
                      onChange={(e) => setEmail(e.target.value)}
                      placeholder="Email" />
                  </FormGroup>
                </Row>

                <Row>
                  <FormGroup className="col-sm-3">
                    <Label for="airline">Flight Number</Label>
                    <Input 
                      type="text" 
                      id="airline" 
                      required="'required'"
                      pattern="[A-Za-zıöçşğü]{2,3}"
                      onChange={(e) => setCallSign(e.target.value)}
                      placeholder="Initials" />
                  </FormGroup>
                  <FormGroup className="col-sm-5 ">
                    <Label for="airline" style={{ opacity: 0 }}>
                      this is a hidden element
                    </Label>
                    <Input
                      type="text"
                      title="Numbers Only"
                      id="flightnum"
                      required="'required'"
                      pattern="[0-9]*"
                      onChange={(e) => setFlightNo(e.target.value)}
                      placeholder="Number"
                    />
                  </FormGroup>
                </Row>
              </Col>

              <Col md="2">
                <br />
                <FormGroup className="col-sm-6">
                <div className="credit-card-container">
                <div className="credit-card">
                <div className="credit-card-inner">
                <div className="credit-card-front">
                <div id="credit-card-type">
                {cardType === "" && <FaCreditCard />}
                {cardType === "Discover" && <FaCcDiscover />}
                {cardType === "AmericanExpress" && <FaCcAmex />}
                {cardType === "Visa" && <FaCcVisa />}
                {cardType === "DinersClub" && <FaCcDinersClub />}
                {cardType === "JCB" && <FaCcJcb />}
                {cardType === "MasterCard" && <FaCcMastercard />}
              </div>

              <div id="credit-card-number">
                {cardNumber == "" && (
                  <div id="credit-card-number">0000 0000 0000 0000</div>
                )}
                {cardNumber}
              </div>

              <div id="credit-card-expiration">
                {expirationDate !== "" && (
                  <div id="credit-card-validthru">Valid Thru</div>
                )}
                {expirationDate}
              </div>

              <div id="credit-card-holder-name">
                {cardHolderName == "" && (
                  <div id="credit-card-holder-name"> YOUR NAME</div>
                )}
                {cardHolderName}
              </div>
            </div>
            <div className="credit-card-back">
              <div className="credit-card-stripe" />
              <div className="credit-card-sig-container">
                <div className="credit-card-signature">{cardHolderName}</div>
                CVC {cvv}
              </div>
              <p className="credit-card-credits">
                Built with Cleave.js, Anime.js, and React Icons.
              </p>
            </div>
          </div>
        </div>
        <form className="credit-card-form">
          <label className="credit-card-input-label">Credit Card Number</label>
          <Cleave
            placeholder="Enter your credit card number"
            options={{ creditCard: true }}
            id="number-input"
            name="number-input"
            className="credit-card-text-input"
            required="'required'"
            onChange={(e) => setCardNumber(e.target.value)}
          />
          <label className="credit-card-input-label">Card Holder Name</label>
          <input
            type="text"
            placeholder="Enter card holder name"
            value={cardHolderName}
            required="'required'"
            onChange={(e) => setCardHolderName(e.target.value)} 
            className="credit-card-text-input"
            maxLength="30"
          />
          <div className="date-and-csv" style={{ display: "flex" }}>
            <div
              style={{ display: "flex", flexDirection: "column", width: "50%" }}
            >
              <label className="credit-card-input-label">Expiration Date</label>
              <Cleave
                options={{
                  date: "true",
                  delimiter: "/",
                  datePattern: ["m", "y"],
                }}
                placeholder="Enter expiration date"
                value={expirationDate}
                className="credit-card-text-input"
                required="'required'"
                onChange={(e) => setExpirationDate(e.target.value)} 
              />
            </div>
            <div
              style={{ display: "flex", flexDirection: "column", width: "50%" }}
            >
              <label className="credit-card-input-label">
                CVC Security Code
              </label>
              <Cleave
                options={{
                  numeral: "true",
                }}
                placeholder="Enter CVC"
                maxLength="3"
                value={cvv}
                className="credit-card-text-input"
                required="'required'"
                onChange={(e) => setCvv(e.target.value)} 
                //onFocus={this.flipCard}
                //onBlur={this.unFlipCard}
              />
            </div>
          </div>
        </form>
      </div>
               </FormGroup>
                <Button className="btn-round" type="submit" color="danger">
                  Submit{" "}
                </Button>
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
