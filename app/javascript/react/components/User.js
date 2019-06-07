import React from 'react';

const User = (props) => {
  return(
    <div className="user_wrapper">
      <div className="user_main_view">
        <div className="user_left">
          <div className="user_photo">
            <a href={`http://www.github.com/${props.user.gitHubUsername}`}>
              {props.user.gitHubUsername}
            </a>
            <a href={`http://www.github.com/${props.user.gitHubUsername}`}>
              <img className="profile_pic" src={props.user.photoUrl} />
            </a>
          </div>
        </div>
        <div
          className="userGraph"
          dangerouslySetInnerHTML={{ __html: props.user.graph }}
        />
        <div className="user_right">
          <div className="currentStreak">
            Current Streak: {props.user.currentStreak} {props.user.currentStreak == 1 ? "day" : "days"}
          </div>
          <div className="longestStreak">
            Longest Streak: {props.user.longestStreak} {props.user.longestStreak == 1 ? "day" : "days"}
          </div>
          <div className="totalCommits">
            Total Commits: {props.user.totalCommits} {props.user.totalCommits == 1 ? "commit" : "commits"}
          </div>
          <div className="totalGreenDays">
            Total Days with commits: {props.user.totalGreenDays} {props.user.totalGreenDays == 1 ? "day" : "days"}
          </div>
          <div className="committedToday">
            Committed Today: {props.user.committedToday ? "yes" :  "not yet"}
          </div>
        </div>
      </div>
      <div
        className="user_graph_phone"
        dangerouslySetInnerHTML={{ __html: props.user.graph }}
      />
      <div className="user_right">
        <div className="currentStreak">
          Current Streak: {props.user.currentStreak} {props.user.currentStreak == 1 ? "day" : "days"}
        </div>
        <div className="longestStreak">
          Longest Streak: {props.user.longestStreak} {props.user.longestStreak == 1 ? "day" : "days"}
        </div>
        <div className="totalCommits">
          Total Commits: {props.user.totalCommits} {props.user.totalCommits == 1 ? "commit" : "commits"}
        </div>
        <div className="totalGreenDays">
          Total Days with commits: {props.user.totalGreenDays} {props.user.totalGreenDays == 1 ? "day" : "days"}
        </div>
        <div className="committedToday">
          Committed Today: {props.user.committedToday ? "yes" :  "not yet"}
        </div>
        <div className="currentLapse">
          Lapse Since Last Commit: {props.user.currentLapse} {props.user.currentLapse == 1 ? "day" :  "days"}
        </div>
      </div>
    </div>
  )
}
export default User ;
