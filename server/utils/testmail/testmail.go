package testmail

import (
    "regexp"
)

func IsEmail(s string) bool {
    r, _ := regexp.Compile(`[\w._%+-]{1,20}@[\w.-]{2,20}.[A-Za-z]{2,3}`)

    if r.MatchString(s) {
        return true
    } else {
        return false
    }
}
