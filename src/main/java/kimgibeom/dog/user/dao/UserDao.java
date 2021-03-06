package kimgibeom.dog.user.dao;

import java.util.List;

import kimgibeom.dog.user.domain.User;

public interface UserDao {
	int addUser(User user);

	List<User> getUsers();

	String getuserPw(String userId);

	User getUserId(String userName, String userPhone);

	User getUserMail(String userId);

	int updatePw(String userId, String userPw);

	// 회원 탈퇴
	int delUser(String userId);
}
