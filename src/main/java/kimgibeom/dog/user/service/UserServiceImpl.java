package kimgibeom.dog.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kimgibeom.dog.user.dao.UserDao;
import kimgibeom.dog.user.domain.User;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;

	@Override
	public int writeUser(User user) {
		return userDao.addUser(user);
	}

	@Override
	public List<User> readUsers() {
		return userDao.getUsers();
	}

	@Override
	public boolean idCheck(String userId) {
		boolean availableId = true;
		List<User> users = userDao.getUsers();
		for (User user : users) {
			System.out.println(user.getUserId());
			if (user.getUserId().equals(userId)) {
				availableId = false;
			}
		}
		System.out.println(availableId);
		return availableId;
	}

	@Override
	public String readuserPw(String userId) {
		return userDao.getuserPw(userId);
	}

	@Override
	public User findUserId(String userName, String userPhone) {
		return userDao.getUserId(userName, userPhone);
	}

	@Override
	public User findUserMail(String userId) {
		return userDao.getUserMail(userId);
	}

	@Override
	public boolean modPw(String userId, String userPw) {
		return userDao.updatePw(userId, userPw) > 0;
	}

	@Override
	public boolean withdrawUser(String userId) {
		return userDao.delUser(userId) > 0;
	}
}
