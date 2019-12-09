import React, { useState, useEffect } from 'react';
import InfiniteScroll from 'react-infinite-scroll-component';

import './App.css';

function App() {

  const [items, setItems] = useState([])
  const [id, setId] = useState(5)


  const getInitialImages = () => {
    var images = []
    let temp = 0

    for (let i = 0; i < 10; i++) {

      for (let index = 0; index < 5; index++) {
        const image = <img src={`/id/${temp}/80`}></img>
        images.push(image)
        temp++;
      }

      const lol = <div id="imagerow">{images}</div>

      setItems(items.concat(lol))
    }

    setId(temp)
  }

  useEffect(() => {
    getInitialImages()
  }, [])




  const baseUrl = "/id/56535/80"

  const style = {
    height: 30,
    border: "1px solid green",
    margin: 6,
    padding: 8
  };






  const fetchMoreData = () => {

    var images = []
    let tempId = id

    for (let i = 0; i < 10; i++) {

      for (let index = 0; index < 5; index++) {
        const image = <img src={`/id/${tempId}/80`}></img>
        images.push(image)
        tempId++
      }

      setId(tempId)


      const lmao = <div id="imagecontainer">{images}</div>

      setItems(items.concat(lmao))
    }
  };


  return (
    <div>
      <h1>demo: react-infinite-scroll-component</h1>
      <hr />
      <InfiniteScroll
        dataLength={items.length}
        //scrollThreshold={0.8}
        next={fetchMoreData}
        hasMore={true}
        loader={<h4>Loading...</h4>}
        height={80}
      >
        {items.map((i, index) => <div>{i}</div>)}
      </InfiniteScroll>
    </div>
  );
}

export default App;
