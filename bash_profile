if [ "${XDG_SESSION_TYPE}" = "wayland" -o "${XDG_SESSION_TYPE}" = "x11" ]
then
    # Use corresponding monitor configuration for Wayland and X11 sessions
    MONITORS_XML="${HOME}/.config/monitors.xml"
    if [ -L "${MONITORS_XML}~" ]
    then
        cp "${MONITORS_XML}" $(readlink -f "${MONITORS_XML}~")
        rm -f "${MONITORS_XML}~"
    fi

    ln -sf ${MONITORS_XML}{.${XDG_SESSION_TYPE},}
    unset MONITORS_XML
fi
