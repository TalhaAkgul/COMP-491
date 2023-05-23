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
import { Button, Container } from "reactstrap";
import {FormGroup, Input, Modal } from "reactstrap";

// core components

function LandingPageHeader() {
  let pageHeader = React.createRef();
  const [liveDemo, setLiveDemo] = React.useState(false);
  React.useEffect(() => {
    if (window.innerWidth < 991) {
      const updateScroll = () => {
        let windowScrollTop = window.pageYOffset / 3;
        pageHeader.current.style.transform =
          "translate3d(0," + windowScrollTop + "px,0)";
      };
      window.addEventListener("scroll", updateScroll);
      return function cleanup() {
        window.removeEventListener("scroll", updateScroll);
      };
    }
  });

  return (
    <>
      <div
        style={{
          backgroundImage: "url(" + require("assets/img/5plane.jpeg") + ")"
        }}
        className="page-header"
        data-parallax={true}
        ref={pageHeader}
      >
        <div className="filter" />
        <Container>
          <div className="motto text-center">
            <h1>ÖdePro</h1>
            <h3>Make in-flight payments effortless!</h3>
            <br />
            <Button className="btn-round" color="danger" href="/make-provision" type="button" outline>
              Make a Provision
            </Button>
            <br /><br />
            <Button className="btn-round" color="danger" type="button" onClick={() => setLiveDemo(true)} outline>
            Dowload the App
          </Button>
          <Modal isOpen={liveDemo} toggle={() => setLiveDemo(false)}>
            <div className="modal-header">

            <button
                aria-label="Close"
                className="close"
                data-dismiss="modal"
                type="button"
                onClick={() => setLiveDemo(false)}
              >
                <span aria-hidden={true}>×</span>
              </button>
              <h5 className="modal-title" id="exampleModalLiveLabel">
                <b><div style={{color:"red"}}>Error</div> Dowload the App</b>
              </h5>
            </div>
            <div className="modal-body">
              <p style={{textAlign:"center"}}>Sorry our app is not on AppStore yet!</p>
              <p style={{textAlign:"center"}}>Please stay tuned :)</p>
              <button
                aria-label="Close"
                className="close"
                data-dismiss="modal"
                type="button"
                onClick={() => setLiveDemo(false)}
              >
                <p aria-hidden={true}><b>Okay</b></p>
              </button>
            </div>
          </Modal>
          </div>
        </Container>
      </div>
    </>
  );
}

export default LandingPageHeader;
