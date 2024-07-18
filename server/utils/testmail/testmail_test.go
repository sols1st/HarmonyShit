package testmail

import "testing"

func TestIsEmail(t *testing.T) {
    _, err := IsEmail("hello")
    if err != nil {
        t.Error("hello is not an email")
    }

    _, err = IsEmail("wjie@qq.com")
    if err != nil {
        t.Error("wjie@qq.com is not an email")
    }
}
