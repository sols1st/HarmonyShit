package utils

import (
    "blogger/utils"
    "log"
    "os"
    "runtime"
    "strconv"
    "strings"
)

var (
    logOut *os.File // log file
    // write by log.Logger support concorrent
    debugLogger *log.Logger
    infoLogger  *log.Logger
    warnLogger  *log.Logger
    errLogger   *log.Logger
)

const flags = log.LstdFlags | log.Llongfile

func SetLogFile(file string) {
    var err error
    // todo: created log directory under the root dir previously
    logOut, err = os.OpenFile(utils.RootPath+"log/"+file, os.O_CREATE|os.O_APPEND|os.O_WRONLY, 0o664)
    if err != nil {
        panic(err)
    } else {
        debugLogger = log.New(logOut, "[Debug]", flags)
        infoLogger = log.New(logOut, "[Info]", flags)
        warnLogger = log.New(logOut, "[Warn]", flags)
        errLogger = log.New(logOut, "[Error]", flags)
    }
}

func Debug(format string, v ...any) {
    debugLogger.Printf(format, v)
}

func Info(format string, v ...any) {
    infoLogger.Printf(format, v)
}

func Warn(format string, v ...any) {
    warnLogger.Printf(format, v)
}

func Error(format string, v any) {
    errLogger.Printf(format, v)
}

func getFileAndLine() (string, string, int) {
    funcName, file, line, ok := runtime.Caller(3)
    if ok {
        return file, runtime.FuncForPC(funcName).Name(), line
    } else {
        return "", "", 0
    }
}

func addPrefix() string {
    file, _, line := getFileAndLine()
    arr := strings.Split(file, "/")
    if len(arr) > 3 {
        arr = arr[len(arr)-3:]
    }
    return strings.Join(arr, "/") + ":" + strconv.Itoa(line)
}
