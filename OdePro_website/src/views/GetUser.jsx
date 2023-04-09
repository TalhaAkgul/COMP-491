import React, { useEffect, useState } from "react";

export default function GetUser() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    fetch("http://localhost:8080/getalldata")
      .then((response) => response.json())
      .then((wer) => setUsers(wer));
  }, []);

  return (
    <div>
      <h1>User Response From API</h1>
      {/* <p>{JSON.stringify(users)}</p> */}
      <ul>
        {users.map((item) => (
          <tr key={item.id}>
            <td>{item.name}</td>
            <td>{item.surname}</td>
            <td>{item.provisionAmount}</td>
            <td>{item.paymentDetails}</td>
            <td>{item.flightNo}</td>
          </tr>
        ))}
      </ul>
    </div>
  );
}
