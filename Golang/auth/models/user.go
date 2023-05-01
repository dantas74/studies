package models

import (
	"errors"
	"golang.org/x/crypto/bcrypt"
	"time"
)

type User struct {
	ID        int       `gorm:"primaryKey" json:"id"`
	Email     string    `gorm:"uniqueIndex" json:"email"`
	FirstName string    `gorm:"notNull" json:"firstName,omitempty"`
	LastName  string    `gorm:"notNull" json:"lastName,omitempty"`
	Password  string    `json:"-"`
	Active    int       `json:"active"`
	CreatedAt time.Time `gorm:"autoCreateTime:true" json:"createdAt"`
	UpdatedAt time.Time `gorm:"autoUpdateTime:true" json:"updatedAt"`
}

// GetAll returns a slice of all users, sorted by last name
func (u *User) GetAll() ([]User, error) {
	var users []User

	if err := Conn.Find(&users).Error; err != nil {
		return nil, err
	}

	return users, nil

}

// GetByEmail returns one user by email
func (u *User) GetByEmail(email string) (User, error) {
	var user User

	if err := Conn.Where(&User{Email: email}).First(&user).Error; err != nil {
		return User{}, err
	}

	return user, nil
}

// GetOne returns one user by id
//func (u *User) GetOne(id int) (*User, error) {
//
//}

// Update updates one user in the models, using the information
// stored in the receiver u
//func (u *User) Update() error {
//
//}

// Delete deletes one user from the models, by ID
//func (u *User) Delete(id int) error {
//
//}

// Insert inserts a new user into the models, and returns the ID of the newly inserted row
//func (u *User) Insert(user User) (int, error) {
//
//}

// ResetPassword is the method we will use to change a user's password.
func (u *User) ResetPassword(email string, password string) error {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), 12)
	if err != nil {
		return err
	}

	Conn.Model(&u).Where(&User{Email: email}).Update("password", string(hashedPassword))

	return nil
}

// PasswordMatches uses Go's bcrypt package to compare a user supplied password
// with the hash we have stored for a given user in the models. If the password
// and hash match, we return true; otherwise, we return false.
func (u *User) PasswordMatches(plainText string) (bool, error) {
	err := bcrypt.CompareHashAndPassword([]byte(u.Password), []byte(plainText))
	if err != nil {
		switch {
		case errors.Is(err, bcrypt.ErrMismatchedHashAndPassword):
			// invalid password
			return false, nil
		default:
			return false, err
		}
	}

	return true, nil
}
