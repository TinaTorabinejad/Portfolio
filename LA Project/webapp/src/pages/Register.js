import React from 'react'
import { useState } from 'react'
import { Link } from "react-router-dom"

export default function Register() {
    const [inputs, setInputs] = useState({});
    const handleChange = (event) => {
        const name = event.target.name;
        const value = event.target.value;
        setInputs((values) => ({ ...values, [name]: value }));
    };
    const handleSubmit = (event) => {
        event.preventDefault(); //will prevent refreshing the page
        alert(
        "A form was submitted: " +
            "USERNAME: " +
            event.target[0].value +
            " EMAIL ADRESS: " +
            event.target[1].value +
            " PASSWORD: " +
            event.target[2].value +
            " PASSWORD CONFIRMED: " +
            event.target[3].value
        );
    };
    return (
        <>
          <body>
            <div className="container">
              <form
                className="form form__input-group"
                id="createAccount"
                onSubmit={handleSubmit}
              >
                <h1 className="form__title"> Create Account </h1>
                <div className="form__input-group">
                  <input
                    type="text"
                    className="form__input"
                    name="name"
                    autofocus
                    placeholder="Username"
                    required
                    value={inputs.name || ""}
                    onChange={handleChange}
                  ></input>
                </div>
                <br/>
                <div className="form__input-group">
                  <input
                    type="text"
                    className="form__input"
                    name="email"
                    autofocus
                    placeholder="Email Adress"
                    required
                    value={inputs.email || ""}
                    onChange={handleChange}
                  ></input>
                </div>
                <br/>
                <div className="form__input-group">
                  <input
                    type="password"
                    className="form__input"
                    name="password"
                    autofocus
                    placeholder="Password"
                    required
                    value={inputs.password || ""}
                    onChange={handleChange}
                  ></input>
                </div>
                <br/>
                <div className="form__input-group">
                  <input
                    type="password"
                    name="confirmPassword"
                    autofocus
                    placeholder="Confirm Password"
                    required
                    value={inputs.confirmPassword || ""}
                    onChange={handleChange}
                  ></input>
                </div>
                <br/>
                <button className="form__button" type="submit">
                  {" "}
                  Submit
                </button>
                <p class="form__text">
                  <Link class="form__link" to="/login" id="linkCreateAccount">
                    {" "}
                    Already have an account? Sign in
                  </Link>
                </p>
              </form>
            </div>
          </body>
        </>
      );
}