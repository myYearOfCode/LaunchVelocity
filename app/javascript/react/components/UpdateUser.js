import React from 'react';

import TextField from "./TextField"

const UpdateUser = (props) => {
  return(
    <form className="callout" onSubmit={props.handleUserFormSubmit}>
      <TextField
        content={props.gitHubUsername}
        label='github username'
        name='gitHubUsername'
        handlerFunction={props.handleConsumedChange}
      />
      <TextField
        content={props.email}
        label='email address'
        name='email'
        handlerFunction={props.handleConsumedChange}
      />
     <input
       type="checkbox"
       name="sendReminders"
       onChange={props.handleConsumedChange}
     />
     Send me reminders.
     <br/>
     <input type="submit" value="Submit"/>
    </form>
  )
}
export default UpdateUser;
