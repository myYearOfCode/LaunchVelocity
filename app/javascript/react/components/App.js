import React from 'react'
import { BrowserRouter, Route, Switch } from "react-router-dom"

import UsersContainer from "../containers/UsersContainer"
import UpdateUser from "./UpdateUser"

export const App = (props) => {
  return (
    <BrowserRouter>
      <Switch>
        <Route path="/" component={UsersContainer} />
        <Route path="/account" component={UpdateUser} />
      </Switch>
    </BrowserRouter>
  )
}

export default App
