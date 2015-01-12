  function addLocalMappings(buffer, maps) {
    maps.forEach(
      function (map) {
        let [cmd, action, extra] = map;
        let actionFunc = action;
        extra || (extra = {});

        if (typeof action == "string") {
          if (action.charAt(0) == ':')
            actionFunc = extra.open ? function () commandline.open("", action, modes.EX)
                                    : function () liberator.execute(action);
          else
            actionFunc = function () events.feedkeys(action, extra.noremap, true);
        }
        extra.matchingUrls = buffer;
        mappings.addUserMap(
          [modes.NORMAL],
          [cmd],
          "Local mapping for " + buffer,
          actionFunc,
          extra
        );
      }
    );
  }

  addLocalMappings(
    /^(http:\/\/(es|www).nicovideo.jp\/watch|http:\/\/(jp|www)\.youtube\.com\/(watch|user)|http:\/\/(www\.)?vimeo\.com\/(channels\/(hd)?#)?\d+)/,
    [
      ['<C-g>', ':mx anc|pageinfo S', ],
      ['i',     ':mx anc|pageinfo S', ],
      ['p',     ':stplay',            ],
      ['m',     ':stmute',            ],
      ['c',     ':stcomment',         ],
      ['z',     ':stlarge',           ],
      ['r',     ':strepeat',          ],
      ['+',     ':stvolume! 10',      ],
      ['-',     ':stvolume! -10',     ],
      ['h',     ':stseek! -10',       ],
      ['l',     ':stseek! 10',        ],
      ['k',     ':stvolume! 10',      ],
      ['j',     ':stvolume! -10',     ],
      ['q',     ':stquality ',        {open: true}],
      ['s',     ':stseek ',           {open: true}],
      ['S',     ':stseek! ',          {open: true}],
      ['v',     ':stvolume ',         {open: true}],
      ['V',     ':stvolume! ',        {open: true}],
      ['o',     ':strelations ',      {open: true}],
      ['O',     ':strelations! ',     {open: true}],
    ]
  );
