import React from 'react';

const User = (props) => {
  return(
    <div className="userWrapper">
      {props.user.gitHubUsername}
      <div dangerouslySetInnerHTML={{ __html: props.user.graph }} />
    </div>
  )
}
export default User ;
