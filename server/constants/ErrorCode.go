package constants

import "log"

const (
    ACCEPT = iota
    EmailError
    EmailExist
    UserNotExist
    UsernameExist
    PasswordError
    PassInvalid
)

func ErrorCodeLog(err int32) {
    switch err {
    case ACCEPT:
        log.Printf("[Response]: code %v, Accept!\n", ACCEPT)
    case EmailError:
        log.Printf("[Response]: code %v, Email address is invalid!\n", EmailError)
    case EmailExist:
        log.Printf("[Response]: code %v, Email address is existed!\n", EmailExist)
    case UserNotExist:
        log.Printf("[Response]: code %v, The User is not existed!\n", UserNotExist)
    case PasswordError:
        log.Printf("[Response]: code %v, The input password is incorrect!\n", PasswordError)
    case PassInvalid:
        log.Printf("[Response]: code %v, The input password' length is less than 6 byte!\n", PassInvalid)
    default:
        log.Printf("Does not the response status code %v\n", err)
    }
}
