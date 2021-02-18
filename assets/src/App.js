import React, { useState } from "react";
import axios from "axios";

const createURL = (url, onSuccess, onError) => (event) => {
  event.preventDefault();
  axios
    .post("http://localhost:4000/api/links", { url: url })
    .then((response) => {
      onError(null);
      onSuccess({ original: url, short: response.data.url });
    })
    .catch((error) => onError(error.response.data.error));
};

export default function App() {
  const [url, setURL] = useState("");
  const [shortURL, setShortURL] = useState({ short: "", original: "" });
  const [error, setError] = useState(null);

  return (
    <div className="flex column">
      <h1 className="title">Min</h1>
      <form onSubmit={createURL(url, setShortURL, setError)}>
        <div className="flex">
          <input
            autoFocus
            id="url"
            onChange={(event) => {
              setError(null);
              setURL(event.target.value);
            }}
            placeholder="Shorten your link"
            type="text"
            value={url}
          ></input>
          <button
            className="button"
            onClick={createURL(url, setShortURL, setError)}
          >
            Shorten
          </button>
        </div>
      </form>
      {shortURL.original && (
        <div className="flex">
          <span>{shortURL.original}</span>
          <a href={shortURL.short}>{shortURL.short}</a>
        </div>
      )}
      {error && <p className="alert alert-danger">{error}</p>}
    </div>
  );
}
