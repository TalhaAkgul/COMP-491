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
function getDisplayCardNumber(numberInput) {
  const placeholder = "****************";
  const newPlaceholder = placeholder.substr(numberInput.length);

  return numberInput.concat("", newPlaceholder).match(/.{1,4}/g);
}
const StyledCard = styled.div`
  font-family: "Space Mono", monospace;
  text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);
  height: 200px;
  width: 320px;
  flex: 0 0 auto;
  padding: 0 1em;

  .card {
    height: 100%;
    border-radius: 8px;
    box-shadow: 1px 1px #aaa3a3;
    background: linear-gradient(45deg, #343a40, #666666, #343a40);
    color: #fff;

    .cardNumber {
      position: relative;
      top: 75px;
      display: flex;
      justify-content: space-between;
      font-size: 1.2em;
      word-spacing: 4px;
      letter-spacing: 2px;
      padding: 0 1em;
    }

    .cardInfo {
      display: flex;
      flex-direction: row;
      justify-content: space-between;
      letter-spacing: 1px;
      line-height: 18px;
      text-transform: uppercase;
      position: relative;
      top: 110px;
      padding: 0 1em;

      span {
        font-size: 11px;
      }

      p {
        margin-top: 8px;
        font-size: 16px;
      }

      .cardExpiry {
        text-align: right;
      }
    }
  }
`;

const StyledTextInput = styled.div`
  color: #343a40;

  label {
    display: inline;
  }

  input {
    box-sizing: border-box;
    width: 100%;
    border-radius: 4px;
    outline: none;
    border: 1px solid #ebecee;
    padding: 10px;
    margin: 10px 0;
  }

  input:focus {
    border-color: #64b5f6;
  }
`;

const StyledCardForm = styled.div`
  flex: 1 0 auto;
  background-color: #e0e0e0;
  border-radius: 8px;
  max-width: 400px;
  overflow: hidden;
  padding: 1em 2em;
  box-shadow: 2px 2px 8px 0px rgba(0, 0, 0, 0.5);

  h2 {
    color: #343a40;
    margin: 0;
    padding-top: 0.25em;
    border-bottom: 1px solid #aeaeae;
    padding-bottom: 0.75em;
  }

  ul {
    list-style: none;
    padding: 0;

    li:not(:last-child) {
      margin-bottom: 15px;
    }
  }
`;

const StyledApp = styled.main`
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  padding: 3em;
  justify-content: space-around;

  & > div:not(:last-child) {
    margin-bottom: 2em;
  }
`;

const TextInput = ({ label, type = "text", id, value, ...props }) => (
  <StyledTextInput>
    {label && <label for={id}>{label}</label>}
    <input id={id} type={type} value={value} {...props} />
  </StyledTextInput>
);

const CreditCard = ({
  cardInfo: { name, number, expiryMonth, expiryYear, cvv },
}) => {
  let cardNumber = getDisplayCardNumber(number);
  let cardName = name < 1 ? "Name" : name;
  let expiry =
    expiryMonth < 1 && expiryYear < 1
      ? "00/00"
      : `${expiryMonth}/${expiryYear}`;

  return (
    <StyledCard>
      <div className="card">
        <div className="cardNumber">
          <span className="numberSection">{cardNumber[0]}</span>
          <span className="numberSection">{cardNumber[1]}</span>
          <span className="numberSection">{cardNumber[2]}</span>
          <span className="numberSection">{cardNumber[3]}</span>
          {cardNumber[4] && (
            <span className="numberSection">{cardNumber[4]}</span>
          )}
        </div>
        <div className="cardInfo">
          <div className="cardName">
            <span>Card Holder</span>
            <p>{cardName}</p>
          </div>
          <div className="cardExpiry">
            <span>Expires</span>
            <p>{expiry}</p>
          </div>
        </div>
      </div>
    </StyledCard>
  );
};

const CardForm = ({
  cardInfo: { name, number, expiryMonth, expiryYear, cvv },
  onChange,
}) => (
  <StyledCardForm>
    <h2>Card Details</h2>
    <form>
      <ul>
        <li>
          <TextInput
            label="Card Holder Name"
            id="name"
            type="text"
            value={name}
            onChange={(e) => onChange({ key: "name", value: e.target.value })}
            minLength="1"
            maxLength="40"
            required
          />
        </li>
        <li>
          <TextInput
            label="Card Number"
            id="number"
            type="text"
            value={number}
            onChange={(e) => onChange({ key: "number", value: e.target.value })}
            placeholder="**** **** **** ****"
            minLength="12"
            maxLength="19"
            required
          />
        </li>
        <li>
          <TextInput
            label="Expiry Month"
            id="expiryMonth"
            type="text"
            value={expiryMonth}
            onChange={(e) =>
              onChange({ key: "expiryMonth", value: e.target.value })
            }
            placeholder="MM"
            minLength="2"
            maxLength="2"
            required
          />
        </li>
        <li>
          <TextInput
            label="Expiry Year"
            id="expiryYear"
            type="text"
            value={expiryYear}
            onChange={(e) =>
              onChange({ key: "expiryYear", value: e.target.value })
            }
            placeholder="YY"
            minLength="2"
            maxLength="4"
            required
          />
        </li>
        <li>
          <TextInput
            label="CVV"
            id="cvv"
            type="text"
            value={cvv}
            onChange={(e) => onChange({ key: "cvv", value: e.target.value })}
            minLength="3"
            maxLength="4"
          />
        </li>
      </ul>
    </form>
  </StyledCardForm>
);

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
          <Row>
            <Form>
              <Row>
                <Col>
                  <Row>
                    <FormGroup className="col-sm-12">
                      <Label for="text">Name</Label>
                      <Input type="text" id="name" placeholder="Name" />
                    </FormGroup>
                  </Row>

                  <Row>
                    <FormGroup className="col-sm-12">
                      <Label for="Surname">Surname</Label>
                      <Input type="text" id="surname" placeholder="Surname" />
                    </FormGroup>
                  </Row>

                  <Row>
                    <FormGroup className="col-sm-12">
                      <Label for="inputEmail">Email</Label>
                      <Input type="email" id="inputEmail" placeholder="Email" />
                    </FormGroup>
                  </Row>

                  <Row>
                    <FormGroup className="col-sm-6">
                      <Label for="airline">Flight Number</Label>
                      <Input type="text" id="airline" placeholder="Initials" />
                    </FormGroup>
                    <FormGroup className="col-sm-6">
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

                <Col>
                  <br />
                  <FormGroup className="col-sm-12">
                  <CardForm cardInfo={cardInfo} onChange={handleOnChange} />
                  <br />
                  </FormGroup>

                  <FormGroup className="col-sm-12">

                  <CreditCard cardInfo={cardInfo} />
                  </FormGroup>

                </Col>
              </Row>
            </Form>
          </Row>
          <br />
        
        
        </Container>
      </div>
      <DemoFooter />
    </>
  );
}

export default ProfilePage;
