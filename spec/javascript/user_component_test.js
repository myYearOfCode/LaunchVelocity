import { shallow } from 'enzyme'
import fetchMock from 'fetch-mock'

import User from '../../app/javascript/react/components/User'

describe('user component display', () => {

  let component;
  let voteBody;

  beforeEach(() => {
    let user = {
      "id": 1,
      "gitHubUsername": "kemmerle",
      "photoUrl": "https://avatars0.githubusercontent.com/u/25392256?s=460&v=4",
      "currentStreak": 0,
      "longestStreak": 1,
      "totalCommits": 9,
      "totalGreenDays": 1,
      "committedToday": true,
      "linkedInUrl": "https://www.linkedin.com/in/allison-kemmerle/"
  }

    component = mount(
      <User
        user = {user}
      />)
  });

  it('should render a User Component', () => {
    expect(component.find(User)).toBePresent();
  });

  it('should display user data', (done) => {
    setTimeout(() => {
      expect(component.text()).toBePresent
      expect(component.text()).toMatch(/kemmerle/)
      expect(component.text()).toMatch(/Current Streak:/)
      expect(component.text()).toMatch(/Longest Streak:/)
      expect(component.text()).toMatch(/Total Commits:/)
      expect(component.text()).toMatch(/Total Days with commits:/)
      done()
    },0)
  });

  it('should display user profile photo', (done) => {
    setTimeout(() => {
      expect(component.find(".user_photo").exists()).toEqual(true)
      done()
    },0)
  });
});
