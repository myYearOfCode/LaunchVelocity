import React from 'react';

const User = (props) => {
  return(
    <div className="userWrapper">
      <div className="user_left">
        <div className="user_photo">
        <a href={`http://www.github.com/${props.user.gitHubUsername}`}>{props.user.gitHubUsername}
          <img className="profile_pic" src={props.user.photoUrl} />
        </a>
        </div>
        <div dangerouslySetInnerHTML={{ __html: props.user.graph }} />
        <div className="user_right">
        <div>Current Streak: {props.user.currentStreak} days</div>
        <div>Longest Streak: {props.user.longestStreak} days</div>
        <div>Total Commits: {props.user.totalCommits} commits</div>
        <div>Total Days with commits: {props.user.totalGreenDays} days</div>
        </div>
      </div>
    </div>
  )
}
export default User ;
