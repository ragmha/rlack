// @flow
import React from 'react';
import { css, StyleSheet } from 'aphrodite';
import { Room, User } from '../../types';

const styles = StyleSheet.create({
  roomSidebar: {
    backgroundColor: '#2e3136',
  },

  header: {
    padding: '20px 15px',
    marginBottom: '10px',
    width: '220px',
  },

  roomName: {
    marginBottom: '0',
    fontSize: '22px',
    lineHeight: '1',
    color: '#fff',
  },

  userList: {
    paddingLeft: '15px',
    listStyle: 'none',
    color: '#fff',
  },

  username: {
    position: 'relative',
    paddingLeft: '20px',
    fontSize: '17px',
    fontWeight: '300',
    ':after': {
      position: 'absolute',
      top: '7px',
      left: '0',
      width: '10px',
      height: '10px',
      borderRadius: '50%',
      background: 'rgb(64,151,141)',
      content: '""',
    },
  },

  listHeading: {
    fontSize: '12px',
    color: '#fff',
    opacity: '.3',
    textTransform: 'uppercase',
    letterSpacing: '.025em',
    fontWeight: '600',
    transition: 'opacity .15s ease',
    padding: '9px 20px',
    display: 'block',
    cursor: 'default',
    whiteSpace: 'nowrap',
    textOverflow: 'ellipsis',
    overflow: 'hidden',
  },
});

type Props = {
  room: Room,
  currentUser: User,
  presentUsers: Array<User>,
}

const RoomSidebar = ({ room, currentUser, presentUsers }: Props) =>
  <div className={css(styles.roomSidebar)}>
    <div className={css(styles.header)}>
      <h2 className={css(styles.roomName)}>{room.name}</h2>
      <div style={{ fontSize: '13px' }}>{currentUser.username}</div>
    </div>
    <div className={css(styles.listHeading)}>Active Users</div>
    <ul className={css(styles.userList)}>
      {presentUsers.map(user =>
        <li key={user.id} className={css(styles.username)}>{user.username}</li>
      )}
    </ul>
  </div>;

export default RoomSidebar;
