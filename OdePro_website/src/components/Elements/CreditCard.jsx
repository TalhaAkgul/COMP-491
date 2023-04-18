import React from "react";
import Cleave from "cleave.js/react";
import anime from "animejs/lib/anime.es.js";
import "assets/css/card.css";

import {
  FaCcAmex,
  FaCcDinersClub,
  FaCcDiscover,
  FaCcJcb,
  FaCcMastercard,
  FaCcVisa,
  FaCreditCard,
} from "react-icons/fa";

class CreditCard extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      cardNumber: "",
      cardHolderName: "",
      cardExpirationDate: "",
      cardCVC: "123",
      cardType: "",
    };

    this.handleInputChange = this.handleInputChange.bind(this);
  }

  handleInputChange(event) {
    //const { name, value } = event.target;
    this.setState({
      cardCVC: "value",
    
  });


    // Call the onCreditCardChange function passed in as a prop with the updated credit card input data
    this.props.onCreditCardChange(this.state);
  }

  // Flip card animations
  flipCard = () => {
    anime({
      targets: ".credit-card-inner",
      rotateY: "180deg",
      duration: "100",
      easing: "linear",
    });
  };
  unFlipCard = () => {
    anime({
      targets: ".credit-card-inner",
      rotateY: "360deg",
      duration: "100",
      easing: "linear",
    });
  };
  // Helper functions
  setCardType = (type) => {
    this.setState({ cardType: type });
  };
  checkSubstring = (length, match) => {
    return this.state.cardNumber.substring(0, length) === match;
  };
  // Controlled inputs
  setNumber = (e) => {
    const cardNumber = e.target.value;
    this.setState({ cardNumber }, () => {
      const { cardNumber } = this.state;
      if (cardNumber[0] === "4") {
        this.setCardType("Visa");
      } else if (this.checkSubstring(4, "6011")) {
        this.setCardType("Discover");
      } else if (this.checkSubstring(2, "51")) {
        this.setCardType("MasterCard");
      } else if (this.checkSubstring(2, "34")) {
        this.setCardType("AmericanExpress");
      } else if (this.checkSubstring(3, "300")) {
        this.setCardType("DinersClub");
      } else if (this.checkSubstring(2, "35")) {
        this.setCardType("JCB");
      } else {
        this.setCardType("");
      }
    });
  };
  setName = (e) => {
    const cardHolderName = e.target.value.toUpperCase();
    this.setState({ cardHolderName });
  };
  setDate = (e) => {
    const cardExpirationDate = e.target.value;
    this.setState({ cardExpirationDate });
  };
  setCVC = (e) => {
    const cardCVC = e.target.value;
    this.setState({ cardCVC });
  };
  render() {
    const {
      cardNumber,
      cardHolderName,
      cardExpirationDate,
      cardCVC,
      cardType,
    } = this.state;

    return (
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
                {cardExpirationDate !== "" && (
                  <div id="credit-card-validthru">Valid Thru</div>
                )}
                {cardExpirationDate}
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
                CVC {cardCVC}
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
            onChange={this.setNumber}
          />
          <label className="credit-card-input-label">Card Holder Name</label>
          <input
            type="text"
            placeholder="Enter card holder name"
            value={cardHolderName}
            onChange={(e) => this.setName(e)}
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
                value={cardExpirationDate}
                className="credit-card-text-input"
                onChange={(e) => this.setDate(e)}
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
                value={cardCVC}
                className="credit-card-text-input"
                onChange={(e) => this.setCVC(e)}
                onFocus={this.flipCard}
                onBlur={this.unFlipCard}
              />
            </div>
          </div>
        </form>
      </div>
    );
  }
}

export default CreditCard;
