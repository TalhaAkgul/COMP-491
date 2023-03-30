import React, { useState } from 'react';

const SearchTable = () => {

const data = [
  { id: 1, name: 'Pinar', surname: 'Erbil', provisionAmount: 28, paymentDetails: 'Ankara', flightNo: 'TK1234' },
  { id: 2, name: 'Betul', surname: 'Demirtas', provisionAmount: 35, paymentDetails: 'Izmir', flightNo: 'TK123' },
  { id: 3, name: 'Talha', surname: 'Akgul', provisionAmount: 42, paymentDetails: 'Istanbul', flightNo: 'TK12344' },
  { id: 4, name: 'Doga Ege', surname: 'Inhanli', provisionAmount: 25, paymentDetails: 'Balikesi', flightNo: 'TK124434' }
];
  const [searchQuery, setSearchQuery] = useState('');
  
  const filteredData = data.filter((item) =>
    item.name.toLowerCase().includes(searchQuery.toLowerCase())
  );
  
  return (
    <div>
      <input
        type="text"
        placeholder="Search..."
        value={searchQuery}
        onChange={(e) => setSearchQuery(e.target.value)}
      />
      {searchQuery && (
        <table>
          <thead>
            <tr>
              <th>Name</th>
              <th>Age</th>
              <th>City</th>
            </tr>
          </thead>
          <tbody>
            {filteredData.map((item) => (
              <tr key={item.id}>
                <td>{item.name}</td>
                <td>{item.age}</td>
                <td>{item.city}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
};

export default SearchTable;
